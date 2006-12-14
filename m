Return-Path: <linux-kernel-owner+w=401wt.eu-S1751942AbWLNSFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWLNSFi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWLNSFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:05:38 -0500
Received: from dvhart.com ([64.146.134.43]:52010 "EHLO dvhart.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbWLNSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:05:37 -0500
Message-ID: <4581916C.9060008@mbligh.org>
Date: Thu, 14 Dec 2006 10:01:16 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>  <20061214005532.GA12790@suse.de>  <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <1166084480.5253.849.camel@pmac.infradead.org> <Pine.LNX.4.64.0612140838410.5718@woody.osdl.org> <45818AFF.4060809@wolfmountaingroup.com>
In-Reply-To: <45818AFF.4060809@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> 
> Again, I agree with EVERY statement Linus made here. We operate exactly 
> as Linus describes, and
> legally, NO ONE can take us to task on GPL issues. We post patches of 
> affected kernel code
> (albiet the code resembles what Linus describes as a "skeleton driver") 
> and our proprietary
> non derived code we sell with our appliances. 


Yeah, like this one?

ftp://ftp.soleranetworks.com/pub/solera/dsfs/FedoraCore6/datascout-only-2.6.18-11-13-06.patch

@@ -1316,8 +1316,8 @@

         mod->license_gplok = license_is_gpl_compatible(license);
         if (!mod->license_gplok && !(tainted & TAINT_PROPRIETARY_MODULE)) {
-               printk(KERN_WARNING "%s: module license '%s' taints 
kernel.\n",
-                      mod->name, license);
+//             printk(KERN_WARNING "%s: module license '%s' taints 
kernel.\n",
+//                    mod->name, license);
                 add_taint(TAINT_PROPRIETARY_MODULE);
         }
  }
@@ -1691,10 +1691,10 @@
         /* Set up license info based on the info section */
         set_license(mod, get_modinfo(sechdrs, infoindex, "license"));

-       if (strcmp(mod->name, "ndiswrapper") == 0)
-               add_taint(TAINT_PROPRIETARY_MODULE);
-       if (strcmp(mod->name, "driverloader") == 0)
-               add_taint(TAINT_PROPRIETARY_MODULE);
+//     if (strcmp(mod->name, "ndiswrapper") == 0)
+//             add_taint(TAINT_PROPRIETARY_MODULE);
+//     if (strcmp(mod->name, "driverloader") == 0)
+//             add_taint(TAINT_PROPRIETARY_MODULE);

         /* Set up MODINFO_ATTR fields */
         setup_modinfo(mod, sechdrs, infoindex);

