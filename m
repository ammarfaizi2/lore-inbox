Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVKESj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVKESj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVKESjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:39:55 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:18614 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932181AbVKESjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:39:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=YXSCzxPOE/BziaTNYO4ZkjJ8P/mk3A8J+j7eDLfXw2y4HF6GeW2Y/gPHe4ynKfxen0DGeNFlxtDC5cHhL9Csjhsb+8WzAREDJDQF3mdvYz9xS9rwa8n8f1J+awMooJ4OLIeYBtUFFoq7PVj6SVbX45RttssN+DXQJ0e4nyqIvgc=;
Date: Sat, 5 Nov 2005 21:39:10 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Thomas Graf <tgraf@suug.ch>
Cc: Patrick McHardy <kaber@trash.net>,
       Brian Pomerantz <bapper@piratehaven.org>, netdev@vger.kernel.org,
       davem@davemloft.net, pekkas@netcore.fi, jmorris@namei.org,
       yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
Message-ID: <20051105183910.GA17215@ms2.inr.ac.ru>
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105010740.GR23537@postel.suug.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Local routes for 10.0.0.3 and 10.0.0.4 have disappeared _without_
> any notification.

Flushes do not generate notifications. The reason is technical: they
are usually massive, do overflow buffer, get lost and listeners have
to do painful resynchronization. The justification: they are useless
because these events are derived.

Alexey
