Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUJHECw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUJHECw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 00:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUJHEBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 00:01:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54186
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267552AbUJHEA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 00:00:28 -0400
Date: Thu, 7 Oct 2004 20:59:06 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: cfriesen@nortelnetworks.com, martijn@entmoot.nl, hzhong@cisco.com,
       jst1@email.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007205906.07218567.davem@davemloft.net>
In-Reply-To: <20041008034848.GA1130@mark.mielke.cc>
References: <41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
	<20041007150035.6e9f0e09.davem@davemloft.net>
	<4165C20D.8020808@nortelnetworks.com>
	<20041007152634.5374a774.davem@davemloft.net>
	<4165C58A.9030803@nortelnetworks.com>
	<20041007154204.44e71da6.davem@davemloft.net>
	<20041008025148.GA724@mark.mielke.cc>
	<20041007203943.24560c33.davem@davemloft.net>
	<20041008034848.GA1130@mark.mielke.cc>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 23:48:48 -0400
Mark Mielke <mark@mark.mielke.cc> wrote:

> Extrapolated, this would be - use of select() on a blocking file descriptor
> is invalid.

It's valid, but it's asking for trouble.  It is going to block on
you under certain circumstances.

