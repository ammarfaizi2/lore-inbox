Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129394AbRB0OEz>; Tue, 27 Feb 2001 09:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRB0OEq>; Tue, 27 Feb 2001 09:04:46 -0500
Received: from mail.ask.ne.jp ([203.179.96.3]:52356 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S129394AbRB0OEb>;
	Tue, 27 Feb 2001 09:04:31 -0500
Date: Tue, 27 Feb 2001 23:01:20 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Ivo Timmermans <irt@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-Id: <20010227230120.32dd0dd3.bruce@ask.ne.jp>
In-Reply-To: <20010227143823.A25058@cistron.nl>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl>
	<20010227143823.A25058@cistron.nl>
X-Mailer: Sylpheed version 0.4.61 (GTK+ 1.2.6; Linux 2.2.18; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001 14:38:23 +0100
Ivo Timmermans <irt@cistron.nl> wrote:
> Heusden, Folkert van wrote:
> > > When running a script (perl in this case) that has DOS-style
> newlines
> > > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > > recognize the \r.  The following patch should fix this (untested).
> > 
> > _should_ it work with the \r in it?
> 
> IMHO, yes.  This set of files were created on Windows, then zipped and
> uploaded to a Linux server, unpacked.  This does not change the \r.

Unzipping the files with the "-ll" option should fix that. There's no
particular reason why the kernel should handle CR+LF; LF has been the
end-of-line character for UN*X systems since Adam was a cowboy.
Changing it now would only lead to a situation where some things would
work with CR+LF and others wouldn't. Let's keep it simple...

--
Bruce Harada
bruce@ask.ne.jp

