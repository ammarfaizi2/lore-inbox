Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129707AbQK3QhH>; Thu, 30 Nov 2000 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129807AbQK3Qg4>; Thu, 30 Nov 2000 11:36:56 -0500
Received: from gate.mesa.nl ([194.151.5.70]:26898 "EHLO gate.mesa.nl")
        by vger.kernel.org with ESMTP id <S129539AbQK3QgQ>;
        Thu, 30 Nov 2000 11:36:16 -0500
Date: Thu, 30 Nov 2000 17:05:39 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Eckhard Jokisch <e.jokisch@u-code.de>
Cc: linux-kernel@vger.kernel.org, gadio@netvision.net.il
Subject: Re: IDE_TAPE problem wiht ONSTREAM DI30
Message-ID: <20001130170539.C25168@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <00113016484200.11054@eckhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.2i
In-Reply-To: <00113016484200.11054@eckhard>; from e.jokisch@u-code.de on Thu, Nov 30, 2000 at 04:26:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 04:26:09PM +0000, Eckhard Jokisch wrote:
> 
> I tried the ide-tape driver for several weeks now. And after some time during
> writing or reading tar stops because of errors.
> 
> Error messages are:
> Nov 30 15:32:20  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0,
> asc =  0, ascq =  2 Nov 30 15:32:25 eckhard last message repeated 1000 times
> Nov 30 15:32:25  kernel: ide-tape: ht0: unrecovered read error on logical block number 461706, skipping

Block number 461706 is about the last block on the tape. So you probably hit
end of media. The end of tape processing in ide-tape.c doesn'y seem to
be quit robust yet.
I ran into such problems since februari or so and have been in contact with
the ide-tape developers and Onstream about it. 
I recently volunteered to try improving the end of media handling (basicly by
implementing early warning EOM) but so far have not had much time to work on it...

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number, so they gave me a name!
                                -- Rupert Hine

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
