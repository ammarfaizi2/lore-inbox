Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUHSPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUHSPRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHSPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:17:20 -0400
Received: from pri-dns1.mtco.com ([207.179.200.251]:12966 "HELO
	pri-dns1.mtco.com") by vger.kernel.org with SMTP id S266523AbUHSPPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:15:52 -0400
From: Tom Felker <tcfelker@mtco.com>
To: Karel Demeyer <kmdemeye@vub.ac.be>
Subject: Re: ati_remote for medion
Date: Thu, 19 Aug 2004 10:16:06 -0500
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1092904136.3352.5.camel@kryptonix>
In-Reply-To: <1092904136.3352.5.camel@kryptonix>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191016.06528.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 03:28 am, Karel Demeyer wrote:
> > I sent a patch to support the Medion RC to the linux-usb-devel list in
> > April 04 (http://thread.gmane.org/gmane.linux.usb.devel/20928) but it
> > got ignored. I think the main problem is to support the different key
> > mappings in the driver. The easiest approach would be to expand the
>
> hard
>
> > coded key translation table for each supported RC. If that would be
> > acceptable, I could prepare a patch.
> >
> > Is there a another way to handle remote control key mappings in the
> > input subsystem?
> >
> > Wolfgang
>
> I'm not sure if my key-mappings are the best, but for my use they are
> excellent.  I added a 'Ctrl', 'Alt', 'Tab', 'Esc' and some more keys.
> The 'fullscreen'-button acts as a 'f', as it makes Totem, TVtime, gXine
> etc go fullscreen ...
>
> I don't know how, but if I still could help in any way, make it clear
> how :)
>
> friendly greets,
>
> Karel "scapor" Demeyer

Are the keycodes unique enough that you can just put the keymaps for both 
remotes into the same table?  I.E. when you wrote your keymaps, did you have 
to remove some of the others to get it to work, or was that just for 
cleanliness?  Otherwise, we'd need to have multiple tables and choose which 
to use based on which remote is being used.

Oh, and do stick around, Karel, someone will need to test the result.

BTW, does anyone know whether the probe function actually needs to check 
whether the product and vendor IDs match the device?  I've seen docs that 
imply yes, but many drivers don't check, and I feel stupid iterating thru the 
table if no.

Have fun,

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

If nature has made any one thing less susceptible than all others of exclusive 
property, it is the action of the thinking power called an idea.
