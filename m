Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUHPPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUHPPFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUHPPFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:05:15 -0400
Received: from www.vc-graz.ac.at ([193.171.121.30]:25481 "EHLO
	proxy.vc-graz.ac.at") by vger.kernel.org with ESMTP id S267656AbUHPPFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:05:09 -0400
From: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Date: Mon, 16 Aug 2004 17:06:25 +0200
User-Agent: KMail/1.7
References: <2tB3a-7rU-19@gated-at.bofh.it> <2tOWp-cF-5@gated-at.bofh.it> <2tQlC-1kl-27@gated-at.bofh.it>
In-Reply-To: <2tQlC-1kl-27@gated-at.bofh.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161706.26069.worf@sbox.tu-graz.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 16. August 2004 16:10 schrieben Sie:
> On Llu, 2004-08-16 at 13:38, Marc Ballarin wrote:
>> Due to the newly added command filtering, you now need to run cdrecord as
>> root. Since cdrecord will drop root privileges before accessing the
>> drive, setuid root won't help
>
> cdrecord should be fine. k3b is issuing something not on the filter
> list.

unfortunately this isn't so

cdrecord itself only works as root
as user, the list of supported modes remains empty, and trying to burn anway 
gives the error
cdrecord: Drive does not support <whatever i try> recording.
cdrecord: Illegal write mode for this drive.

k3b is just a frontend. the reaction on the empty modes list is quite correct 
actually, because cdrecord itself behaves the same

Worf
