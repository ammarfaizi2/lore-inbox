Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRKSQZB>; Mon, 19 Nov 2001 11:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279963AbRKSQYw>; Mon, 19 Nov 2001 11:24:52 -0500
Received: from [195.66.192.167] ([195.66.192.167]:50955 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S277012AbRKSQYc>; Mon, 19 Nov 2001 11:24:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 18:24:11 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01111916225301.00817@nemo> <01111916583804.00817@nemo> <E165qq7-0003QD-00@mauve.csi.cam.ac.uk>
In-Reply-To: <E165qq7-0003QD-00@mauve.csi.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <0111191824110B.00817@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 16:00, you wrote:
> On Monday 19 November 2001 4:58 pm, vda wrote:
> > On Monday 19 November 2001 14:36, James A Sutherland wrote:
> > > $ mkdir test
> > > $ echo content > test/file
> > > $ chmod a-r test
> > > $ ls test
> > > ls: test: permission denied
> > > $ cat test/file
> > > content
> > > $ chmod a=r test
> > > $ ls test
> > > ls: test/file: Permission denied
> >
> > Hmm... I do actually tested this and last command succeeds
> > (shows dir contents). You probably meant cat test/file, not ls...
>
> Nope, ls.
>
> [james@dax p2i]$ ls test
> ls: test/file: Permission denied
> [james@dax p2i]$ ls -l test
> ls: test/file: Permission denied
> total 0

Looks like we have different ls :-). Mine lists 'r only' dir with no problem.

> Anyway, as Al Viro has pointed out, R!=X. It's been like that for a very
> long time, it's deliberate, not a misfeature, and it's staying like that
> for the foreseeable future.

Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
to chmod and friends:

chmod -R a+R dir  - sets r for files and rx for dirs

--
vda
