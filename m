Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVKRAhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVKRAhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVKRAhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:37:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:21736 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751071AbVKRAhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:37:01 -0500
Subject: Re: tty_flip_buffer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, mansarov@us.ibm.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 01:08:42 +0000
Message-Id: <1132276122.25914.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-15 at 15:38 -0600, V. Ananda Krishnan wrote:
> tty_insert_flip_string_flags() API?  When I looked into the 
> implementation of the tty_insert_flip_string_flags API in tty_io.c, I 
> was little confused.

The flags buffer is used to hold the state of each character. Its
usually TTY_NORMAL and is set to TTY_NORMAL by the functions not taking
a flag value. It serves the same task as the flag buffer in the old
tty_flip.

> Also, can any one explain me the function of the free queue head in the 
> struct tty_bufhead?

Private to the tty layer pointer to allow small buffers as used with
byte at a time uarts to be recycled not freed/allocated

Alan

