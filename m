Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262909AbSJGHtJ>; Mon, 7 Oct 2002 03:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbSJGHtI>; Mon, 7 Oct 2002 03:49:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23190 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262909AbSJGHtI>;
	Mon, 7 Oct 2002 03:49:08 -0400
Date: Mon, 07 Oct 2002 00:48:00 -0700 (PDT)
Message-Id: <20021007.004800.82100313.davem@redhat.com>
To: bazsi@balabit.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unix domain sockets bugfix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021007073532.GA15799@balabit.hu>
References: <20021007073532.GA15799@balabit.hu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Balazs Scheidler <bazsi@balabit.hu>
   Date: Mon, 7 Oct 2002 09:35:32 +0200
   
   The returned socklen is 2, but the sockaddr.family is not touched. A fix is
   below:

Since msg->msg_namelen is zero, msg->msg_name should not be
interpreted in any way at all.
