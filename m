Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265608AbUALUhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUALUhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:37:15 -0500
Received: from mail.webmaster.com ([216.152.64.131]:53986 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265608AbUALUhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:37:11 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "tabris" <tabris@tabris.net>, "Hunt, Adam" <ahunt@solvone.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: SecuriKey
Date: Mon, 12 Jan 2004 12:37:06 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEDHJHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200401111446.27403.tabris@tabris.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	How do you generate a one-time-pad? a one time pad must be
> by definition
> truly random, and be used only once. and if you can send the Securikey
> via a secure channel at the same time as the message, then you don't need
> the OTP.

	To truly qualify as an OTP, the data would have to be random, used once,
and somehow securely transfered to both ends of what will be the secure
channel. This is, shall we say politely, seldom done for modern
cryptography.

	However, many modern encryption schemes do require data that must be
unpredictable. If you want to encrypt a message using RSA, you generally use
a random key for a symmetric cypher and use RSA to protect the random key
rather than the (usually larger) message itself.

> 	I should also mention that the problem with 'generating' an
> OTP via any
> mechanical or algorithmic means is impossible as at best an OTP will only
> be pseudo-random, and therefore with identical inputs (assuming it is
> possible, which we can assume here for the sake of theory and security),
> the same OTP can be generated, thus breaking our assumption/necessity of
> non-deterministic output.

	Except we don't live in a deterministic world, we live in a quantum world.
It is nearly trivial to mechanically produce data that is truly random. All
you need is a reverse biased zener diode.

	Even if you do believe the world is deterministic, against the weight of
modern science, I really doubt you believe that anyone outside a sealed box
can predict microscopic zone temperature variations within a box and
therefore predict the phase jitter between two crystal oscillators inside
it.

	DS


