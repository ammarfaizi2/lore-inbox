Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUJPKYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUJPKYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 06:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUJPKYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 06:24:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15365 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268368AbUJPKYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 06:24:48 -0400
Date: Sat, 16 Oct 2004 12:24:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Robert White <rwhite@casabyte.com>
Cc: "'David S. Miller'" <davem@davemloft.net>,
       "'Olivier Galibert'" <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041016102433.GA17984@alpha.home.local>
References: <20041008064104.GF19761@alpha.home.local> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAf9vmEwEK20KyGtJj9HtARQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAf9vmEwEK20KyGtJj9HtARQEAAAAA@casabyte.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 03:42:55PM -0700, Robert White wrote:
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
> On Behalf Of Willy Tarreau
> 
> > As I asked in a previous mail in this overly long thread, why not returning
> > zero bytes at all. It is perfectly valid to receive an UDP packet with 0
> 
> Zero bytes is "end of file".  Don't go trying to co-opt end of file.  That way lies
> madness and despair.

Please explain me what "end of file" means with UDP. If your UDP-based app
expects to receive a zero when the other end stops transmitting, then it
might wait for a very long time. As opposed to TCP, there's no FIN control
flag to tell the remote host that you sent your last packet.

Willy

