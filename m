Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130964AbRCFOzP>; Tue, 6 Mar 2001 09:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRCFOzG>; Tue, 6 Mar 2001 09:55:06 -0500
Received: from ns.suse.de ([213.95.15.193]:43025 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130825AbRCFOyu>;
	Tue, 6 Mar 2001 09:54:50 -0500
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Paul Flinders <paul@dawa.demon.co.uk>,
        Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <200103061355.HAA96253@tomcat.admin.navo.hpc.mil>
X-Yow: I have a TINY BOWL in my HEAD
From: Andreas Schwab <schwab@suse.de>
Date: 06 Mar 2001 15:54:48 +0100
In-Reply-To: <200103061355.HAA96253@tomcat.admin.navo.hpc.mil>
Message-ID: <je1ysbkkw7.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.99
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:

|> Andreas Schwab <schwab@suse.de>:Andreas Schwab <schwab@suse.de>Andreas Schwab <schwab@suse.de>
|> > Paul Flinders <paul@dawa.demon.co.uk> writes:
|> > 
|> > |> Andreas Schwab wrote:
|> > |> 
|> > |> > This [isspace('\r') == 1] has no significance here.  The right thing to
|> > |> 
|> > |> > look at is $IFS, which does not contain \r by default.  The shell only splits
|> > |> 
|> > |> > words by "IFS whitespace", and the kernel should be consistent with it:
|> > |> >
|> > |> > $ echo -e 'ls foo\r' | sh
|> > |> > ls: foo: No such file or directory
|> > |> 
|> > |> The problem with that argument is that #!<interpreter> can be applied
|> > |> to more than just shells which understand $IFS, so which environment
|> > |> variable does the kernel pick?
|> > 
|> > The kernel should use the same default value of IFS as the Bourne shell,
|> > ie. the same value you'll get with /bin/sh -c 'echo "$IFS"'.  This is
|> > independent of any settings in the environment.
|> > 
|> > |> It's a difficult one - logically white space should terminate the interpreter
|> > 
|> > No, IFS-whitespace delimits arguments in the Bourne shell.
|> 
|> IFS can be defined in the environment.

No, the shell won't import it.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
