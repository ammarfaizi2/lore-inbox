Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTEOWja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTEOWja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:39:30 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:45318 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264276AbTEOWj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:39:29 -0400
Subject: Re: [patch] NCR5380.c fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andries.Brouwer@cwi.nl
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, torvalds@transmeta.com
In-Reply-To: <UTC200305152245.h4FMjAj26766.aeb@smtp.cwi.nl>
References: <UTC200305152245.h4FMjAj26766.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 May 2003 17:52:06 -0500
Message-Id: <1053039127.3998.23.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 17:45, Andries.Brouwer@cwi.nl wrote:
> -					else if (cmd->SCp.Status != GOOD)
> +					else if (status_byte(cmd->SCp.Status) != GOOD)

Well...if we're doing it this way, any reason not to use the newly
minted SAM_STAT_GOOD and SAM_STAT_CHECK_CONDITION?

James


