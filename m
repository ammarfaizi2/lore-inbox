Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVDTIr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVDTIr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDTIr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:47:28 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:31643 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261454AbVDTIrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:47:16 -0400
Message-ID: <4266168C.7050301@lab.ntt.co.jp>
Date: Wed, 20 Apr 2005 17:45:00 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org> <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org> <42660B6B.6040600@lab.ntt.co.jp> <20050420082655.GA2756@taniwha.stupidest.org>
In-Reply-To: <20050420082655.GA2756@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Apr 20, 2005 at 04:57:31PM +0900, Takashi Ikebe wrote:
> 
> 
>>hmm.. most internet base services will use TCPv4 TCPv6 SCTP...
>>AF_UNIX can not use as inter-nodes communication.
> 
> 
> You can send file descriptors (the actually file descriptors
> themselves, not their contents) to another process over a socket.
> 
> A nearly ten-year old example is attached (ie. this isn't new or
> magical or specific to Linux).
> 
> 
> 
> ------------------------------------------------------------------------
> int main()
> {
>     int fds[2];
>     int fd = -1;
>     int rc = socketpair(AF_UNIX, SOCK_STREAM, 0, fds);
Hmm interest enough,
But please see man.

NOTES
       On Linux, the only supported domain for this call is AF_UNIX (or
 syn-
       onymously,  AF_LOCAL).   (Most  implementations have the same
restric-
       tion.)

Only for AF_UNIX..


Well, as many said Live patching is very historical & authoritative
function on especially carrier, telecom vendor.
If linux want to be adopted on mission critical world, this function is
esseintial.

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
