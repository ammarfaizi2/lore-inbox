Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUJNUsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUJNUsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUJNUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:47:54 -0400
Received: from rage.4t2.com ([217.20.115.48]:16075 "EHLO rage.4t2.com")
	by vger.kernel.org with ESMTP id S267301AbUJNSqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:46:17 -0400
Date: Thu, 14 Oct 2004 20:44:11 +0200
From: Thomas Weber <l_linux-kernel@mail2news.4t2.com>
To: David Howells <dhowells@redhat.com>
Cc: "Rusty Russell (IBM)" <rusty@au1.ibm.com>, dwmw2@redhat.com,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041014184411.GA4140@4t2.com>
References: <20040810002741.GA7764@kroah.com> <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com> <30797.1092308768@redhat.com> <20040812111853.GB25950@devserv.devel.redhat.com> <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com> <27175.1095936746@redhat.com> <30591.1096451074@redhat.com> <10345.1097507482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10345.1097507482@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
X-4t2Systems-MailScanner: Found to be clean
X-4t2Systems-MailScanner-From: l_linux-kernel@mail2news.4t2.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 04:11:22PM +0100, David Howells wrote:
> 
> > Sign the whole thing.  Use a signature format which doesn't suck (ASN1
> > parsing in the kernel?  Hmm...).  Have your build system spit out two
> > RPMs, one with full debug modules, and one without.  This is not rocket
> > science.
> 
> You make it sound so simple...

I'n not a kernel hacker or anything like this. But reading this thread i
might have another idea to approach the problem - if it had been
discussed before just ignore me, i haven't searched much.

How about creating the /lib/modules/ fs tree in a file, stuff all your
modules there, sign that file and mount it ro via loopback to some fixed
place like /modules?
The kernel would only have to check the signature of the whole modules
container once. From my limited understanding it wouldn't need much more
kernel code and the userland tools to maintain the container file (adding, 
signing) already exist too. After all it's the sysadmin who has to
decide which modules he trusts (and puts into the container).

as i said, just an idea from a non kernel hacking simple thinking admin,
  Tom
