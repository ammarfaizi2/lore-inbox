Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbUBWU1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbUBWU1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:27:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:63972 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262034AbUBWU1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:27:24 -0500
X-Authenticated: #20799612
Date: Mon, 23 Feb 2004 21:24:25 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223202425.GB13914@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222214255.0a6488c7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222214255.0a6488c7.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 09:42:55PM -0800, Paul Jackson wrote:
> >  #!/usr/bin/awk -F \t -f
> 
> If your primary need is to set the awk field separator, how about
> setting FS (or IFS, depending on which awk) in a BEGIN section
> in the script?

Well, this was just the example we used in the discussion I mentioned.
In this case you are right. But what about

#!/usr/bin/awk --posix -f

to enable expressions like [0-9]{1,2}. There are really usefull
parameters for awk, shells, ... you can't use easily in scripts (IIRC,
perl has to parse the shebang line on its own because of this - although
this is really not the job of an interpreter.)

The "\" part: Yes, there are not many examples, where you really need
this, because it's not that likely to have filenames or parameters
containing spaces. That's why I said, this part could get some
"#ifdef CONFIG_SHEBANG_ESCAPE" or could even be deleted from the patch.

Here, I'd like to know what people consider more important:
compatibility for old scripts with shebang lines containing backslashes
or the possibility to have file names or paramaters containing white
space characters.

Regards,

	Hansjoerg Lipp
