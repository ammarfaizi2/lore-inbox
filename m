Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291985AbSBNXoJ>; Thu, 14 Feb 2002 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291983AbSBNXn6>; Thu, 14 Feb 2002 18:43:58 -0500
Received: from coruscant.franken.de ([193.174.159.226]:53175 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S291987AbSBNXnr>; Thu, 14 Feb 2002 18:43:47 -0500
Date: Fri, 15 Feb 2002 00:37:56 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Chris Chabot <chabotc@reviewboard.com>
Cc: Nick Craig-Wood <ncw@axis.demon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: 2.4.18-pre9: iptables screwed?
Message-ID: <20020215003756.U28092@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Chris Chabot <chabotc@reviewboard.com>,
	Nick Craig-Wood <ncw@axis.demon.co.uk>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.samba.org
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com> <20020208094649.J26676@sunbeam.de.gnumonks.org> <20020214161225.A2867@axis.demon.co.uk> <3C6C0977.7030004@reviewboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C6C0977.7030004@reviewboard.com>; from chabotc@reviewboard.com on Thu, Feb 14, 2002 at 08:01:11PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Prickle-Prickle, the 44th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 08:01:11PM +0100, Chris Chabot wrote:
> I ran into the same problems with 2.4.18pre9, however upgrading to 
> iptables 1.2.5 fixed the problem. (there's no redhat packages for it 
> yet, i did a compile of the source pkg)

As stated in my earlier replies to this issue:

Certain vendor RPMs for iptables have (unvoluntarily?) compiled in iptables
debugging .  At least RedHat and Mandrake seem to be falling in this category.

The debugging code does not work with recent kernels, but nobody was
assuming debugging would be enabled in production systems.

There are two solutions to the problem:

a) update to an iptables package which doesn't have debugging enabled
   (which is default with iptables source as distributed by the netfilter
    coreteam)

or 

b) use iptables from current CVS when you really need to have debugging
   enabled.  I will release iptables-1.2.6 soon, which will also have
   the debugging code fixed.

> 	-- Chris

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
