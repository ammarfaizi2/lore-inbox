Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSAQA4P>; Wed, 16 Jan 2002 19:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSAQA4G>; Wed, 16 Jan 2002 19:56:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35714 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286758AbSAQAzt>;
	Wed, 16 Jan 2002 19:55:49 -0500
Date: Wed, 16 Jan 2002 16:54:48 -0800 (PST)
Message-Id: <20020116.165448.26534238.davem@redhat.com>
To: balbir_soni@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F232Ej1I7QY9zK4unnr000139b2@hotmail.com>
In-Reply-To: <F232Ej1I7QY9zK4unnr000139b2@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You totally missed what move_addr_to_user() does, which is in fact
truncate the copied len to what the user supplied.  Also, the comments
in move_addr_to_user even quote the bits of 1003.1g you a referring
to.

In short, the bug you suggest is not there.
