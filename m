Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269500AbUJFXoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269500AbUJFXoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUJFXlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:41:08 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:31644
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269500AbUJFXhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:37:48 -0400
Date: Wed, 6 Oct 2004 16:36:53 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: nhorman@redhat.com, hzhong@cisco.com, aebr@win.tue.nl, joris@eljakim.nl,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006163653.29f8ef93.davem@davemloft.net>
In-Reply-To: <4164713F.3080506@nortelnetworks.com>
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
	<41645892.9060105@redhat.com>
	<4164713F.3080506@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2004 16:27:11 -0600
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> Neil Horman wrote:
> 
> > Again, shouldn't this just mean that recvfrom should not be called 
> > without the MSG_ERRQUEUE flag set?
> 
> Does a message with a bad udp checksum even get sent up as a queued error message?

No, it doesn't, MSG_ERRQUEUE is used for other things.
