Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQLCPVD>; Sun, 3 Dec 2000 10:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbQLCPUx>; Sun, 3 Dec 2000 10:20:53 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:38459 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129786AbQLCPUp>; Sun, 3 Dec 2000 10:20:45 -0500
From: Armin Schindler <mac@melware.de>
Reply-To: mac@melware.de
Organization: Cytronics & Melware
To: linux-kernel@vger.kernel.org
Subject: Q: tq_scheduler slower on SMP ?
Date: Sun, 3 Dec 2000 15:40:05 +0100
X-Mailer: KMail [version 1.0.21]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00120315500101.18928@cops>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with kernel 2.2.17 I need to have a
function in my driver to handle some data.
I used BH with tq_immediate, but I found
out, that my function need to be called
outside of interrupt context, but still as
soon as I need it. 
So I decided to use the tq_scheduler queue and
put my function on the task_queue in my interrupt handler.
It seems to work good without SMP, but with SMP
my function is called with delays of many msecs.

Since the tq_scheduler queue is only started from
schedule(), do I need to set some flag to run schedule
asap ?
Or has someone better idea for my function ?

Thanx,

Armin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
