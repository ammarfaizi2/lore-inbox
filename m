Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbULKN2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbULKN2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 08:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbULKN2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 08:28:31 -0500
Received: from asplinux.ru ([195.133.213.194]:31498 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261932AbULKN2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 08:28:30 -0500
Message-ID: <41BAF6A7.6070102@sw.ru>
Date: Sat, 11 Dec 2004 16:31:19 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [VFS-EXPORTS] Why generic_forget_inode() is not exported?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question about EXPORTS in VEFS:
if sb->drop_inode method is set, than it's called in iput_final().
But it's impossible to call neither generic_drop_inode(), nor 
generic_forget_inode() inside this handler. Only generic_delete_inode() 
is accessiable.

why generic_delete_inode() is exported and generic_forget_inode() is not?
It looks like it should. At least, from VFS interface point of view.

Kirill

