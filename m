Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273817AbRIXGsw>; Mon, 24 Sep 2001 02:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273816AbRIXGsn>; Mon, 24 Sep 2001 02:48:43 -0400
Received: from t2.redhat.com ([199.183.24.243]:3834 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273813AbRIXGsY>; Mon, 24 Sep 2001 02:48:24 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010924002854.A25226@codepoet.org> 
In-Reply-To: <20010924002854.A25226@codepoet.org>  <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <16995.1001284442@redhat.com> 
To: andersen@codepoet.org
Cc: David Woodhouse <dwmw2@cambridge.redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Sep 2001 07:48:47 +0100
Message-ID: <32737.1001314127@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andersen@codepoet.org said:
> Is jffs2 still showing the
>     Child dir "." (ino #1) of dir ino #1 appears to be a hard link
> problem?  I saw you patched mkfs.jffs2 after my changes -- do you
> still need me to hunt down that bug I added? 

Yes please. The patch I committed just made it happier with a relative (or
no) root directory - it was changing into the specified directory and then
still prepending its name to every path. I assume it's still emitting a
dirent for '.' in the root directory as it was before. The JFFS2 kernel code
doesn't like that very much.

--
dwmw2


