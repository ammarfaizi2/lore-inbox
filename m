Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVACCSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVACCSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 21:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVACCSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 21:18:34 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:46250 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261279AbVACCSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 21:18:33 -0500
Message-ID: <41D8AB74.7010409@sbcglobal.net>
Date: Sun, 02 Jan 2005 21:18:28 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why clear_buffer_uptodate in end_buffer_write_sync on write error?
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to understand the file systems.  I'm making good progress, 
but I don't get this.  If the buffer is marked not up to date because 
the write failed, won't this cause block_prepare_write to try and read 
the buffer using ll_rw_block thereby overwriting the data that couldn't 
be written?  Is this desirable?  Perhaps I'm confused?
