Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264312AbRFGEZQ>; Thu, 7 Jun 2001 00:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264313AbRFGEZG>; Thu, 7 Jun 2001 00:25:06 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:28939 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S264312AbRFGEY6>; Thu, 7 Jun 2001 00:24:58 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed in the
In-Reply-To: <E157kxf-0000UE-00@the-village.bc.nu>
	<p05100310b744a22f02a6@[192.109.102.42]>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 07 Jun 2001 06:24:38 +0200
In-Reply-To: <p05100310b744a22f02a6@[192.109.102.42]> (Matthias Urlichs's message of "Thu, 7 Jun 2001 05:25:30 +0200")
Message-ID: <tgbso0diih.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs <smurf@noris.de> writes:

> Select is defined as to return, with the appropriate bit set, if/when
> a nonblocking read/write on the file descriptor won't block. You'd get
> EBADF in this case, therefore causing the select to return would be a
> Good Thing.

How do you avoid race conditions if more than one thread is creating
file descriptors?  I think you can only do that under very special
circumstances, and it definitely requires some synchronization.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
