Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279156AbRKFNH6>; Tue, 6 Nov 2001 08:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279180AbRKFNHi>; Tue, 6 Nov 2001 08:07:38 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:22798 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S279156AbRKFNH3>; Tue, 6 Nov 2001 08:07:29 -0500
Date: Tue, 6 Nov 2001 14:07:27 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: <pcg@goof.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ip_conntrack & timing out of connections
In-Reply-To: <20011106121947.A678@schmorp.de>
Message-ID: <Pine.LNX.4.33.0111061405560.1427-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 pcg@goof.com wrote:

> Nov  6 02:39:55 doom kernel: ip_conntrack: table full, dropping packet. 

You probably need to do something like:

# We need a lot of concurrent connections
echo 65536 > /proc/sys/net/ipv4/ip_conntrack_max

(or how many you will need). Be aware  that it will use up more memory - 
the netfilter docs can tell you how much.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
If you only have a hammer
everything looks like a nail
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

