Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271032AbRIRNAX>; Tue, 18 Sep 2001 09:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRIRNAO>; Tue, 18 Sep 2001 09:00:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271005AbRIRM74>; Tue, 18 Sep 2001 08:59:56 -0400
Subject: Re: [PATCH] lazy umount (1/4)
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Tue, 18 Sep 2001 14:03:50 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        alex@foogod.com (Alex Stewart), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010918110815.B16592@emma1.emma.line.org> from "Matthias Andree" at Sep 18, 2001 11:08:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jKXW-0000sG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> something is wrong with the process and it's prone to deadlocks. Even if
> kill -9 just means "fail this all further syscalls instantly" in such

It will already do that. The moment it gets to the syscall return its
history
