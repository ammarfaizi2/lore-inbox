Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUBFSMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbUBFSMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:12:35 -0500
Received: from main.gmane.org ([80.91.224.249]:39648 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265603AbUBFSMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:12:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel
Date: Fri, 06 Feb 2004 19:12:28 +0100
Message-ID: <yw1xsmhoqdpv.fsf@kth.se>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos>
 <52smhounpn.fsf@topspin.com> <Pine.LNX.4.53.0402061258110.4045@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:W2q/NJNndA+NKUBreoQuJBG8tfk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Fri, 6 Feb 2004, Roland Dreier wrote:
>
>>     Richard> If some major changes are being considered, I think it's
>>     Richard> time to get rid of the:
>>
>>     Richard> do { } while(0) stuff that permiates a lot of MACROS and
>>     Richard> just use the { } as they were designed.
>>
>>     Richard> Before everybody screams, think. It's perfectly correct
>>     Richard> to start a new "program unit" without a conditional
>>     Richard> expression.  You just add a curley-brace, then close the
>>     Richard> brace when you are though.
>>
>> This is totally, totally wrong.  If you get rid of do { } while (0),
>> then you can't use the macro in an if statement.  Read any C FAQ for
>> details, or try the following:
>>
>
> Yes you can. You just don't use an ';' if you are going
> to use 'else'.

Now suppose someone changes the macro into an inline function.  Then
the ; is suddenly required.  How are you going to deal with that?

-- 
Måns Rullgård
mru@kth.se

