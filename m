Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTDKNVG (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTDKNVG (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 09:21:06 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:59315 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264353AbTDKNVF (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 09:21:05 -0400
Message-ID: <3E96C417.B11A5AA0@Bull.Net>
Date: Fri, 11 Apr 2003 15:33:11 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Aniruddha M Marathe <aniruddha.marathe@wipro.com>,
       linux-kernel@vger.kernel.org,
       Chandrashekhar RS <chandra.smurthy@wipro.com>
Subject: Re: [BUG] settimeofday(2) succeeds for microsecond value more 
 thanUSEC_PER_SEC and for negative value
References: <94F20261551DC141B6B559DC491086723E0EB7@blr-m3-msg.wipro.com> <3E966009.1060501@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
>   I suppose it is too much to ask, but it would be nice if
> do_sys_settimeofday() took a timespec instead of a timeval.  Of course
> this changes the interface for all the archs, but it would allow the
> clock_settimeofday to send in the nsec value.
IMHO on IA64 it would not be a bad idea since internally everything is
computed on nsec. Currently there is conversion from usec to nsec at the
beginning of do_sys_settimeofday() :-)
I could support you on IA64 to do the change if this is needed.

Eric
