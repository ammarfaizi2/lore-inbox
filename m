Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281007AbRKGVSr>; Wed, 7 Nov 2001 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280990AbRKGVRu>; Wed, 7 Nov 2001 16:17:50 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9724
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281006AbRKGVQ1>; Wed, 7 Nov 2001 16:16:27 -0500
Date: Wed, 7 Nov 2001 13:16:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: alad@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: FTP query
Message-ID: <20011107131619.B20245@mikef-linux.matchmail.com>
Mail-Followup-To: alad@hss.hns.com, linux-kernel@vger.kernel.org
In-Reply-To: <65256AFD.004D2573.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65256AFD.004D2573.00@sandesh.hss.hns.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 07:33:48PM +0530, alad@hss.hns.com wrote:
> 
> 
> Hi,
>     Sorry for posting it to the wrong list. But people here can surely help me
> out.
> 
> Let us suppose a operator is FTPing a file "temp.c" to a folder "/home/work".
> And a process "A" is monitoring "/home/work". How would process "A" would know a
> file "temp.c" is completely transfered in "/home/work"
> 
> Please CC it to me as I am not subscribed to list
> 

There are several ways, some only available to a root process...

Root priv required:
run lsof -n on the file to see if the ftp server still has it open...

normal user:
monitor modified time and size over a period of time to see if it has
changed in that time, if not, it's done...

Mike
