Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269457AbUJFULq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269457AbUJFULq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUJFUKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:10:22 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:44186
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269451AbUJFUHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:07:14 -0400
Date: Wed, 6 Oct 2004 13:06:15 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: hzhong@cisco.com, aebr@win.tue.nl, joris@eljakim.nl,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006130615.4f65a920.davem@davemloft.net>
In-Reply-To: <41644D86.4010500@nortelnetworks.com>
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
	<41644D86.4010500@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2004 13:54:46 -0600
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> Would it be so bad to do the checksum before marking the socket readable? 

Yes, because if we do that we have to make two passes over the
data instead of one.  It does make a big difference.
