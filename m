Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310178AbSCAXZJ>; Fri, 1 Mar 2002 18:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310177AbSCAXY7>; Fri, 1 Mar 2002 18:24:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310173AbSCAXYq>;
	Fri, 1 Mar 2002 18:24:46 -0500
Message-ID: <3C800D66.F613BBAA@zip.com.au>
Date: Fri, 01 Mar 2002 15:23:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au>,
		<3C7FE7DD.98121E87@zip.com.au>; from akpm@zip.com.au on Fri, Mar 01, 2002 at 12:43:09PM -0800 <20020301162016.A12413@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> The issue here is that it sleeps too much
> and what's really happening and that we are forcing 8 disk drives
> toshare 64/128 request buffers rather than provide each physical disk
> with what it really needs.

OK.  So would it suffice to make queue_nr_requests an argument to
a new blk_init_queue()?

-	blk_init_queue(q, sci_request);
+	blk_init_queue_ng(q, sci_request, 1024);



-
