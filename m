Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVANUt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVANUt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVANUt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:49:28 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:33412 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262119AbVANUtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:49:18 -0500
Date: Fri, 14 Jan 2005 21:49:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 4/8 ] ltt for 2.6.10 : fs/ events
Message-ID: <20050114204957.GB8385@mars.ravnborg.org>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <41E76288.2080004@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E76288.2080004@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim.

>  void __wait_on_buffer(struct buffer_head * bh)
>  {
> +	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_BUF_WAIT_START, 0, 0, NULL);

Pleae use the subsystem name in both function name and constant - like:
> +	ltt_ev_fs(LTT_EV_FS_BUF_WAIT_START, 0, 0, NULL);

This is commonly practice.

Comment is relevant for:
file_system	=>	fs
network		=>	net
memory		=>	mm

	Sam
