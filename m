Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbQJ2BDi>; Sat, 28 Oct 2000 21:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbQJ2BD1>; Sat, 28 Oct 2000 21:03:27 -0400
Received: from Cantor.suse.de ([194.112.123.193]:21522 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131116AbQJ2BDN>;
	Sat, 28 Oct 2000 21:03:13 -0400
Date: Sun, 29 Oct 2000 02:03:11 +0100
From: Andi Kleen <ak@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Dave S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: tcp_do_sendmsg() allocation still broken ?
Message-ID: <20001029020311.A16003@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0010281859570.865-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010281859570.865-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Oct 28, 2000 at 07:12:44PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 07:12:44PM -0200, Marcelo Tosatti wrote:
> 
> David,
> 
> tcp_do_sendmsg() still allocates using GFP_KERNEL when it can't, it seems: 

tcp_do_sendmsg() should only be called from process context, because it can
sleep for other reasons anyways. 

If someone calls it from interrupt context it needs to be fixed.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
