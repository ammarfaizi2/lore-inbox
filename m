Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293081AbSCEM4M>; Tue, 5 Mar 2002 07:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293106AbSCEM4D>; Tue, 5 Mar 2002 07:56:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28033 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293081AbSCEMzq>;
	Tue, 5 Mar 2002 07:55:46 -0500
Date: Tue, 05 Mar 2002 04:53:30 -0800 (PST)
Message-Id: <20020305.045330.23012378.davem@redhat.com>
To: vak@cronyx.ru
Cc: alan@cymru.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] added SIGIO support for /dev/tap0 and other
 netlink-based drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <007501c1c154$bca973c0$48b5ce90@crox>
In-Reply-To: <007501c1c154$bca973c0$48b5ce90@crox>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The SIGIO should be sent via sock_wake_async() via
sock_def_write_space() and friends.

