Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTAMOst>; Mon, 13 Jan 2003 09:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbTAMOst>; Mon, 13 Jan 2003 09:48:49 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:62692 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S261527AbTAMOss>; Mon, 13 Jan 2003 09:48:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: patch for errno-issue (with soundcore)
Date: Mon, 13 Jan 2003 15:57:33 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301131457.24264.thomas.schlichter@web.de> <1042470839.18624.19.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1042470839.18624.19.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131557.33135.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13. Jan. 2003 16:13, Alan Cox wrote:
> This actually shows a bug that has always been lurking. What if we load two
> modules firmware at the same time. errno needs to be task private or we
> perhaps need an errno_sem ?

OK, I think I see the problem now!
But is soundcore the only place where 'errno' is used? Does this problem not 
occur if any task modifies the errno value and an other one depends on its 
previous value? I think this could happen even if no modules are used...
