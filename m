Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135689AbRAGDad>; Sat, 6 Jan 2001 22:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135688AbRAGDaX>; Sat, 6 Jan 2001 22:30:23 -0500
Received: from Cantor.suse.de ([194.112.123.193]:9736 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135477AbRAGDaF>;
	Sat, 6 Jan 2001 22:30:05 -0500
Date: Sun, 7 Jan 2001 04:29:59 +0100
From: Andi Kleen <ak@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010107042959.A14330@gruyere.muc.suse.de>
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com>; from greearb@candelatech.com on Sat, Jan 06, 2001 at 02:33:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 02:33:27PM -0700, Ben Greear wrote:
> I'm hoping that I can get a few comments on this code.  It was added
> to (significantly) speed up things like 'ifconfig -a' when running with
> 4000 or so VLAN devices.  It should also help other instances with lots
> of (virtual) devices, like FrameRelay, ATM, and possibly virtual IP
> interfaces.  It probably won't help 'normal' users much, and in it's final
> form, should probably be a selectable option in the config process.
> 
> Anyway, let me know what you think!

Does it make any significant different with the ifconfig from newest nettools? I 
removed a quadratic algorithm from ifconfig's device parsing, and with that I was 
able to display a few thousand alias devices on a unpatched kernel in reasonable time.



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
