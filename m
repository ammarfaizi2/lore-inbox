Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTAOR2G>; Wed, 15 Jan 2003 12:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTAOR2G>; Wed, 15 Jan 2003 12:28:06 -0500
Received: from [66.70.28.20] ([66.70.28.20]:3078 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266735AbTAOR2F>; Wed, 15 Jan 2003 12:28:05 -0500
Date: Wed, 15 Jan 2003 18:36:56 +0100
From: DervishD <raul@pleyades.net>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Changing argv[0] under Linux. This MUST work...
Message-ID: <20030115173656.GG86@DervishD>
References: <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD> <20030115131617.GA8621@unthought.net> <20030115162219.GB86@DervishD> <20030115164731.GB8621@unthought.net> <20030115171009.GF86@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030115171009.GF86@DervishD>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jakob :)

    Your solution of exec'ing ourselves MUST undoubtly work (well, I
know that this an affirmation that I will lament XDDDD), because it
only relies on 'exec()' passing the argv[0] you provide as the
argv[0] of the invoked binary, and that should work or programs like
'/bin/login' will stop working... They rely on the same principle,
since they need to prepend an '-' to the shell name to make it a
login shell :))) Didn't remember this until now!

    So, if you do 'execl(ourselves, "my new name", ..., NULL)', the
argv[0] received by the binary specified in 'ourselves' MUST be 'my
new name'. Otherwise '/bin/login' and a good bunch of shells won't
work...

    If you happen to come to Spain at any point in the future, just
tell me, I'll buy you a beer (or crack, or whatever you use XDDD).

    Thanks :)

    Raúl
