Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVGREne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVGREne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 00:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGREne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 00:43:34 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:62869 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261419AbVGREmr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 00:42:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BMLx74ukqyCBxemrZ+PZE2aFqc1QzUIYMWVNvvWS8sFglTDodMkJjjHbXbr/Rar1posxll5iyWncs8aj7rDr12w4iQDnSc4ikSkh+pp4g9ESFk/eES5xBWizp0fKxhvPw0kIerYSCvFasgrSIieR9ONskvuipDinadgFtHV/qac=
Message-ID: <3faf056805071721422594dd20@mail.gmail.com>
Date: Mon, 18 Jul 2005 10:12:46 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
Reply-To: vamsi krishna <vamsi.krishnak@gmail.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Increasing virtual address space of a process, by treating virtual address's as offsets in secondary memory.
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan, mm-hackers,

I have been working this idea of increasing virtual address space of a
process with the help of secondary memory. At first this may seem like
the same virtual memory concept but its not the case.

Imagine all the virtual address the compiler generates while creating
the binary as relocatable offsets on the disk, and the application
specific runtime mmaps and munmaps these dynamically.

I was searching a lot about work on this, and found your reply where
you say that we can increase the virtual address space by mmaping and
munmaping programatically ourself.

So is the bigmem kernel implement this? may be  you can give me some
insight into this.

Some inputs on this would be highly appreciated.

Sincerely,
Vamsi kundeti. 

PS: Please refer this kernel mailing list email.


<--------------------------------------------------SNIP--------------------------------------------------------------------------->
Re: BIGMEM kernel question
From: Alan Cox (alan@lxorguk.ukuu.org.uk)
Date: Fri Jul 06 2001 - 16:46:16 EST



> Ahh. That makes sense. So how can I change the chunk size from 64k to
> something higher (I assume I could set it to 128k to effectively double
> that 3GB to 6GB)?

I think you misunderstand. If you want more than 3Gb you will have to map and
unmap stuff yourself. You only have 3Gb of per process address space due to
x86 weaknesses (lack of seperate kernel/user spaces without tlb flush
overhead nightmares)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/

    * Next message: Donald Becker: "Re: why this 1ms delay in
mdio_read? (cont'd from "are ioctl calls supposed to take this
long?")"
    * Previous message: Rik van Riel: "Re: BIGMEM kernel question"
    * In reply to: Eric Anderson: "Re: BIGMEM kernel question"
    * Next in thread: Brian Gerst: "Re: BIGMEM kernel question"
    * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 
<------------------------------------------------------SNIP----------------------------------------------------------------------------->
