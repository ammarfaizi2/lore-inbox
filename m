Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVBCAqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVBCAqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVBCAot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:44:49 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:27494 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262860AbVBCAmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:42:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V8RxSeV5qwQLpEAu6sl2x4Snup9MuFkQVnQMJdc800rqI0wGW6AR/ZjCwOWkxNz0FYUuoellkyWBkKEzdRYJgwaPwwuhMCx4R1NVrgfyWkNsFnTMzqtk1rJH0dNJaojhCc0RJiHoPwVOiJQnlb5xek/8xLJxAJ9dZGn3sfhe7rE=
Message-ID: <58cb370e05020216427757693b@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:42:18 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 12/29] ide: add ide_hwgroup_t.polling
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025538.GM621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025538.GM621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:55:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 12_ide_hwgroup_t_polling.patch
> >
> >       ide_hwgroup_t.polling field added.  0 in poll_timeout field
> >       used to indicate inactive polling but because 0 is a valid
> >       jiffy value, though slim, there's a chance that something
> >       weird can happen.

Is there really a possibility of something weird?

I'm not claiming that I like this way of coding but poll_timeout
is assigned either to '0' or to 'jiffies + WAIT_WORSTCASE'.

Bartlomiej
