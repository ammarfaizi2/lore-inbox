Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSE0Kqr>; Mon, 27 May 2002 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSE0Kqq>; Mon, 27 May 2002 06:46:46 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:45067 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316594AbSE0Kqp>; Mon, 27 May 2002 06:46:45 -0400
Date: Mon, 27 May 2002 12:15:39 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tasklet scheduled after end of rmmod
Message-ID: <20020527121539.O635@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <7wptzlllek.fsf@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 03:34:27PM +0200, Emmanuel Michon wrote:
> as far as I understand nothing prevents a scheduled tasklet to have
> Linux jump to its routine, when the routine is in a module being
> rmmod'd. How should I take care of this?
 
tasklet_kill() in your module_exit() code looks like it does the
job.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
