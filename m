Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJPLoF>; Tue, 16 Oct 2001 07:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276021AbRJPLnz>; Tue, 16 Oct 2001 07:43:55 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:41225 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276018AbRJPLnm>; Tue, 16 Oct 2001 07:43:42 -0400
Message-ID: <XFMail.011016124547.jws22@cam.ac.uk>
X-Mailer: XFMail 1.3.2pre1 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Date: Tue, 16 Oct 2001 12:45:47 +0100 (BST)
From: James Scott <jws22@cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Bug warning in skbuff.c
Cc: James Scott <jws22@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

(n.b. linux-2.4.10)

I am working on a new type of network at Cambridge University, and am writing a
linux kernel driver for the NIC we've built.  I get the following in
/var/log/messages once per packet:

Oct 16 12:27:42 cerealkiller kernel: Warning: kfree_skb on hard IRQ c300c6d0

because I am calling dev_kfree_skb from a hard IRQ for every outgoing packet
(the TX-complete interrupt).

I know that I can (and perhaps should) do as much as possible in a bottom half
tasklet, however right now this is all experimental and "inconsiderate" code.

What I want to know is - is the use of kfree_skb on a hard IRQ actually that
evil?  Is the "bug" just to remind me to be considerate, or is it to point out
real problems that might occur (e.g. in OOM cases?)

Thanks,
James

PS Please mail me explicitly (Im not on linux-kernel).  Thanks for your help.
