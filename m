Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKNJym>; Tue, 14 Nov 2000 04:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKNJyc>; Tue, 14 Nov 2000 04:54:32 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:27915 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S129069AbQKNJyP>; Tue, 14 Nov 2000 04:54:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <3864.974181019@kao2.melbourne.sgi.com>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 14 Nov 2000 10:19:31 +0100
In-Reply-To: Keith Owens's message of "Tue, 14 Nov 2000 16:50:19 +1100"
Message-ID: <tgy9ymlxlo.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> All these patches against request_module are attacking the problem at
> the wrong point.

Agreed.

> The kernel can request any module name it likes, using any string it
> likes, as long as the kernel generates the name.  The real problem
> is when the kernel blindly accepts some user input and passes it
> straight to modprobe, then the kernel is acting like a setuid
> wrapper for a program that was never designed to run setuid.

I don't think it's a good idea to distribute such stuff over the whole
kernel.  Better control it at a single place, either when passing the
parameter down to modprobe, or in modprobe itself.  Everything else is
too error-prone.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
