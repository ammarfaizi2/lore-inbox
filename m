Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbQKANBY>; Wed, 1 Nov 2000 08:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbQKANBN>; Wed, 1 Nov 2000 08:01:13 -0500
Received: from tnt-dal-42-210.dallas.net ([209.44.42.210]:29708 "EHLO
	bfgbhome.inetint.com") by vger.kernel.org with ESMTP
	id <S130311AbQKANBJ>; Wed, 1 Nov 2000 08:01:09 -0500
Date: Wed, 1 Nov 2000 06:59:40 -0600
From: "Brian F. G. Bidulock" <bidulock@openswitch.org>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tnt uses obsolete (PF_INET,SOCK_PACKET)
Message-ID: <20001101065940.A20416@openswitch.org>
Reply-To: bidulock@openswitch.org
Mail-Followup-To: f5ibh <f5ibh@db0bm.ampr.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200011011117.MAA28584@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200011011117.MAA28584@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Wed, Nov 01, 2000 at 12:17:40PM +0100
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openswitch.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

f5ibh,

It means that it should be opening a PF_PACKET socket (see packet(7))
instead of a PF_INET, SOCK_PACKET (see COMPATIBILITY ip(7)):

    "For compatibility with Linux 2.0, the obsolete socket(PF_INET,
     SOCK_RAW, protocol) syntax is still supported to open a
     packet(7) socket.  This is deprecated and should be replaced by
     socket(PF_PACKET, SOCK_RAW, protocol) instead.  The main
     difference is the new sockaddr_ll address structure for generic
     link layer information instead of sockaddr_pkt." - ip(7)

--Brian

On Wed, 01 Nov 2000, f5ibh wrote:

> Hi,
> 
> Nov  1 12:09:12 debian-f5ibh kernel: tnt uses obsolete (PF_INET,SOCK_PACKET)
> 
> I got often this message, it is harmless (seems to be). What does it means ?
> 
> ---
> Regards
> 		jean-luc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Brian F. G. Bidulock
http://www.openss7.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
