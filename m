Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbRARJed>; Thu, 18 Jan 2001 04:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132249AbRARJeW>; Thu, 18 Jan 2001 04:34:22 -0500
Received: from Cantor.suse.de ([194.112.123.193]:40718 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131439AbRARJeR>;
	Thu, 18 Jan 2001 04:34:17 -0500
Date: Thu, 18 Jan 2001 10:34:14 +0100
From: Andi Kleen <ak@suse.de>
To: Rick Jones <raj@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118103414.A18205@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.10.10101171259470.10031-100000@penguin.transmeta.com> <3A661A00.E3344A18@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A661A00.E3344A18@cup.hp.com>; from raj@cup.hp.com on Wed, Jan 17, 2001 at 02:17:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 02:17:36PM -0800, Rick Jones wrote:
> How does CORKing interact with ACK generation? In particular how it
> might interact with (or rather possibly induce) standalone ACKs?

It doesn't change the ACK generation. If your cork'ed packets gets sent
before the delayed ack triggers it is piggy backed, if not it is send 
individually. When the delayed ack triggers depends; Linux has dynamic
delack based on the rtt and also a special quickack mode to speed up slow 
start. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
