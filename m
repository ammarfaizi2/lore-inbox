Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279472AbRKSQAl>; Mon, 19 Nov 2001 11:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279588AbRKSQAa>; Mon, 19 Nov 2001 11:00:30 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:4502 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279472AbRKSQA1>; Mon, 19 Nov 2001 11:00:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 16:00:12 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <01111916225301.00817@nemo> <E165pWu-0000Pi-00@mauve.csi.cam.ac.uk> <01111916583804.00817@nemo>
In-Reply-To: <01111916583804.00817@nemo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165qq7-0003QD-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 4:58 pm, vda wrote:
> On Monday 19 November 2001 14:36, James A Sutherland wrote:

> > $ mkdir test
> > $ echo content > test/file
> > $ chmod a-r test
> > $ ls test
> > ls: test: permission denied
> > $ cat test/file
> > content
> > $ chmod a=r test
> > $ ls test
> > ls: test/file: Permission denied
>
> Hmm... I do actually tested this and last command succeeds
> (shows dir contents). You probably meant cat test/file, not ls...

Nope, ls. 

[james@dax p2i]$ ls test
ls: test/file: Permission denied
[james@dax p2i]$ ls -l test
ls: test/file: Permission denied
total 0

(There is something incredibly stupid about the first one: ls is unable to, 
er, read the name of the named file?!)


Anyway, as Al Viro has pointed out, R!=X. It's been like that for a very long 
time, it's deliberate, not a misfeature, and it's staying like that for the 
foreseeable future.


James.
