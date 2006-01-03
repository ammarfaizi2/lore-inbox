Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWACHHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWACHHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 02:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWACHHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 02:07:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751184AbWACHHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 02:07:45 -0500
Date: Mon, 2 Jan 2006 23:07:14 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: usb: replace __setup("nousb") with __module_param_call
Message-Id: <20060102230714.3aa4f85b.zaitcev@redhat.com>
In-Reply-To: <200601030147.46504.dtor_core@ameritech.net>
References: <20051220141504.31441a41.zaitcev@redhat.com>
	<200512220110.52466.dtor_core@ameritech.net>
	<20051222002423.1791d38b.zaitcev@redhat.com>
	<200601030147.46504.dtor_core@ameritech.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 01:47:46 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> +static int __init obsolete_checksetup(char *line, int len)
> -		int n = strlen(p->str);
> -		if (!strncmp(line, p->str, n)) {
> +		if (!strncmp(line, p->str, len) && len == strlen(p->str)) {

This looks like it should work, with the disclaimer that I am not
infallible.

But even if it does, my patch saved reading, so I think it should be
applied as well.

-- Pete
