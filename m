Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424554AbWKKLwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424554AbWKKLwN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424556AbWKKLwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:52:13 -0500
Received: from wshld2.trema.com ([194.103.215.196]:7137 "HELO
	webshieldout.corp.trema.com") by vger.kernel.org with SMTP
	id S1424554AbWKKLwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:52:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sat, 11 Nov 2006 12:36:54 +0100
Message-ID: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Thread-Index: AccFNRRKPohzikdyRCK5fQAHdh/mfwAUFnfw
From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Solomon Peachy" <pizza@shaftnet.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>, <Christian@ogre.sisk.pl>,
       <Hoffmann@albercik.sisk.pl>
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Saturday, November 11, 2006 3:03 AM
To: Benjamin Herrenschmidt; Solomon Peachy
Cc: Rafael J. Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML;
Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl; Christian Hoffmann
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari
4005 with radeonfb enabled

On Sat, 11 Nov 2006 12:49:06 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2006-11-11 at 00:31 +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > We've just got the appended report.  Could you please have a look at
this?
> 
> There are many possible reasons for that. The most likely is that the
> BIOS isn't bringing the chip back on resume, causing radeonfb to
> crash when trying to access it.
> 

I assume from this:

> > Greetings,
> > Rafael
> > 
> > 
> > ----------  Forwarded Message  ----------
> > 
> > Subject: [Suspend-devel] resume not working on acer ferrari 4005
with radeonfb enabled
> > Date: Friday, 10 November 2006 20:44
> > From: "Christian Hoffmann"
<Christian.Hoffmann@wallstreetsystems.com>
> > To: suspend-devel@lists.sourceforge.net
> > 
> > Hello,
> >  
> > when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt
resume
> > anymore. Screen stays black and nothing works anymore, no capslock
light, no
    ^^^^^^^

>that it's a regression, from some unknown-previous-kernel-version.



> > ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> > acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
> >  
> > You can see dmesg output and lspci -vv output here 
> >  http://christianhoffmann.de/temp/radeon.log
> >  http://christianhoffmann.de/temp/lspci.log
> >  
> > Thanks a lot for any input.
> >  
> > Chris
> >  
> > PS: I use kernel 2.18.1 + patch for radeonfb from
> > http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view

>That's http://www.shaftnet.org/~pizza/radeonfb-atom-2.6.18-v6a.diff.

>What happens when that patch isn't applied?


Then the radeonfb doesn't kick in at all (guess some pci ids are added
in that patch).

BTW: resume/suspend works ok if I have the vesa fb enabled.

Chris






Privileged or confidential information may be contained in this message.  If you are not the addressee of this message please notify the sender by return and thereafter delete the message, and you may not use, copy, disclose or rely on the information contained in it. Internet e-mail may be susceptible to data corruption, interception and unauthorised amendment for which Wall Street Systems does not accept liability. Whilst we have taken reasonable precautions to ensure that this e-mail and any attachments have been swept for viruses, Wall Street Systems does not accept liability for any damage sustained as a result of viruses.  Statements in this message or attachments that do not relate to the business of  Wall Street Systems are neither given nor endorsed by the company or its Directors.

