Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRKHBTO>; Wed, 7 Nov 2001 20:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKHBTF>; Wed, 7 Nov 2001 20:19:05 -0500
Received: from smtp1.libero.it ([193.70.192.51]:13785 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S281228AbRKHBSz>;
	Wed, 7 Nov 2001 20:18:55 -0500
Date: Thu, 8 Nov 2001 02:10:57 +0100
From: antirez <antirez@invece.org>
To: David Ford <david@blue-labs.org>
Cc: antirez <antirez@invece.org>,
        "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-ID: <20011108021057.E568@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <20011108012051.C568@blu> <3BE9D7BD.7030308@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE9D7BD.7030308@blue-labs.org>; from david@blue-labs.org on Wed, Nov 07, 2001 at 07:54:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 07:54:21PM -0500, David Ford wrote:
> That doesn't solve anything if the data value includes ( or ).  It just 
> avoids ' ' in the data value and adds complexity.

Wrong, exampel of () in data:

((data)(\(\)))

About the complexity. It only "looks" complex. But from the
machine point of view it's very simple to parse.
Note that the strong advantage of this isn't the quoting,
you can quote anyway in 1000 different ways. The advantage
is that data is structured and parsing does not rely on
spaces or newlines, but just on ().
With this syntax you can express data as complex and structured
as you want but the parsing is still simple.

Regards,
Salvatore
