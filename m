Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSHHUnp>; Thu, 8 Aug 2002 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSHHUnp>; Thu, 8 Aug 2002 16:43:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49606 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318064AbSHHUnn>; Thu, 8 Aug 2002 16:43:43 -0400
Date: Thu, 8 Aug 2002 16:47:24 -0400
From: Doug Ledford <dledford@redhat.com>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: i810 sound broken...
Message-ID: <20020808164724.B18073@redhat.com>
Mail-Followup-To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
	"linux-kernel@vger" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it> <1028561325.18478.55.camel@irongate.swansea.linux.org.uk> <1028572739.4406.2.camel@frasier> <20020807110554.D10872@redhat.com> <1028746148.2275.22.camel@voyager>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028746148.2275.22.camel@voyager>; from juergen.sawinski@mpimf-heidelberg.mpg.de on Wed, Aug 07, 2002 at 08:49:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2002 at 08:49:08PM +0200, Juergen Sawinski wrote:
> My i845 box seems to only have a tertiary codec (waiting for
> verification from Intel) which is only accesible via DMA. I already
> started to make this work... hope, I can show some code end of the week.
> 
> But there's sth. about i810_ac97_get. The ICH4 manual says, reads _must
> not_ cross DWord boundaries. Could there be a problem? 

Actually, I just solved an i845 issue here.  I have a patch that should 
enable yours to work I think.  It's against the i810_audio.c driver in 
Alan's current tree.  I've attached that patch.  If the patch doesn't work 
for you, the complete source code can be found at 
http://people.redhat.com/dledford/i810_audio.c.gz (shift-click on the link 
in a browser to get it to download the file cleanly).  Drop that source in 
place and use it to test.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--nVMJ2NtxeReIH9PS
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="i810-0.22.patch.gz"
Content-Transfer-Encoding: base64

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

--nVMJ2NtxeReIH9PS--
