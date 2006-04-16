Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDPN3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDPN3e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 09:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWDPN3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 09:29:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750741AbWDPN3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 09:29:33 -0400
Message-ID: <44424688.3050802@redhat.com>
Date: Sun, 16 Apr 2006 09:28:40 -0400
From: Prarit Bhargava <prarit@redhat.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kristen Accardi <kristen.c.accardi@intel.com>
CC: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mochel@linux.intel.com,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru
Subject: Re: [patch 1/3] acpi: dock driver
References: <20060412221027.472109000@intel.com>	 <1144880322.11215.44.camel@whizzy>  <20060412222735.38aa0f58.akpm@osdl.org> <1145054985.29319.51.camel@whizzy>
In-Reply-To: <1145054985.29319.51.camel@whizzy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if my previous reply made it out to the list and everyone 
else.  I'm in the process of switching email addresses :(.  Sorry if 
this is a repeat Kristen, et al.... My apologies if this is the case ...

>+static struct dock_dependent_device * alloc_dock_dependent_device(acpi_handle handle)
>+{
>+	struct dock_dependent_device *dd;
>+
>+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
>+	if (dd) {
>+		dd->handle = handle;
>+		INIT_LIST_HEAD(&dd->list);
>+		INIT_LIST_HEAD(&dd->hotplug_list);
>+	}
>+	return dd;
>+}
>+
>
>  
>
What do you do if this returns NULL (ie, kzalloc did not succeed)?  Then 
you blindly use the pointer elsewhere in the code?

P.

P.
