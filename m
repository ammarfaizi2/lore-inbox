Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSFDTYJ>; Tue, 4 Jun 2002 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSFDTYI>; Tue, 4 Jun 2002 15:24:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62713 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316629AbSFDTYG>; Tue, 4 Jun 2002 15:24:06 -0400
Subject: Re: Patch for broken Dell C600 and I5000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Pete Zaitcev <zaitcev@redhat.com>, Ian Soboroff <ian.soboroff@nist.gov>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020604181801.GA6419@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 21:29:57 +0100
Message-Id: <1023222597.3439.189.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 19:18, Erik Andersen wrote:
> On a related note...  I recently updated to Bios A20 and I find
> the fan stays on after resuming...  Also, in order for resume to
> complete sucessfully I find I need to never start X with dri so
> that agp support and the r128 module are not loaded.  If they
> load then the laptop hangs when doing a resume.  Known problems?

Yes - it appears that some of the register state needs to be restored
into the AGP registers when we resume. We have hooks for that but
someone needs to sit down and either try rerunning the init code for the
AGP on a resume or sit with a serial console working out what bits need
fixup

