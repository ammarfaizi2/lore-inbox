Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVAYB25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVAYB25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVAYB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:28:57 -0500
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:43021 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S261628AbVAYB2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:28:48 -0500
Date: Mon, 24 Jan 2005 17:27:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: =?ISO-8859-1?B?UmFt824=?= Rey Vicente <rrey@usuarios.retecal.es>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/journal.c:2966!
Message-Id: <20050124172732.7978d541.akpm@digeo.com>
In-Reply-To: <41F4434E.50000@usuarios.retecal.es>
References: <41F4434E.50000@usuarios.retecal.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 25 Jan 2005 01:27:59.0915 (UTC) FILETIME=[1B1F97B0:01C5027D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramón Rey Vicente <rrey@usuarios.retecal.es> wrote:
>
> I get this with 2.6.11-rc2
> 
>  kernel BUG at fs/reiserfs/journal.c:2966!

Is this repeatable?

    /* we aren't allowed to close a nested transaction on a different
    ** filesystem from the one in the task struct
    */
    if (cur_th->t_super != th->t_super)
      BUG() ;

very strange.  What mount options are you using on that fs?
