Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWGRVQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWGRVQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWGRVQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:16:37 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:6310 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932091AbWGRVQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:16:36 -0400
Date: Tue, 18 Jul 2006 18:16:31 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Thomas Dillig <tdillig@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
Message-ID: <20060718181631.13f6f052@doriath.conectiva>
In-Reply-To: <44BC5A3F.2080005@stanford.edu>
References: <44BC5A3F.2080005@stanford.edu>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.4.0-rc3 (GTK+ 2.10.0; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006 20:49:19 -0700
Thomas Dillig <tdillig@stanford.edu> wrote:

| [4]
| 239 drivers/usb/misc/usblcd.c
| NULL dereference of variable "urb".

 This is a false positive.

 The tool is not taking the return statement into consideration
(and usb_free_urb() checks if the urb variable is NULL before deferencing
it).

-- 
Luiz Fernando N. Capitulino
