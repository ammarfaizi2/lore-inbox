Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285693AbRLHAEz>; Fri, 7 Dec 2001 19:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285689AbRLHAEr>; Fri, 7 Dec 2001 19:04:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:786 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285694AbRLHAEc>; Fri, 7 Dec 2001 19:04:32 -0500
Message-ID: <3C114CFB.50403@zytor.com>
Date: Fri, 07 Dec 2001 15:12:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: On re-working the major/minor system
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> <E16CJnv-0005c0-00@the-village.bc.nu> <20011207135100.A17683@codepoet.org> <9urbtm$69e$1@cesium.transmeta.com> <20011207145535.A18152@codepoet.org> <3C113CFA.5090109@zytor.com> <20011207160734.A18800@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

> On Fri Dec 07, 2001 at 02:04:42PM -0800, H. Peter Anvin wrote:
> 
>>It's clear a painful change is needed.  **We don't have a choice.**
>>However, the fewer places we have to make source code changes the better.
>>
> 
> Sure.  I'm not arguing again the change.  Just making sure
> everyone 100% understands that we have just thown any prayer of
> binary compatibility with anything less then 2.5.x....
> 
> But lets look on the bright side though.  Since we are going to
> be having a flag day _anyways_ we may as well make the most of
> it.  I can think of 20 things off the top of my head that are
> being retained in the name of binary cmpatibilty that can easily
> move to the trash bucket.  :)
> 
> For example, I would _love_ for Linux to standardize syscall
> numbers across all architectures, guarantee that userspace gets
> the exact same stack setup for all arches, we might as well fixup
> proc, etc, etc, etc.
> 


Not going to happen.  Linux deliberately choose against that, because in
Linux, syscall numbers are generally (except x86) compatible with the
dominant vendor Unix on the platform.

> 
> That works, and should prevent most major problems.  Hmm.  At
> least for cpio there are 6 chars worth of device info in there,
> so we coule easily go to 48 bits without RPM problems.  Or redhat
> could fix rpm to use tarballs like debs do, and then we could go
> to 64 bit devices no problem.
> 


The big stubling block seems to be NFSv2.

	-hpa


