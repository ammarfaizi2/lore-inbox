Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVDRPPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVDRPPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVDRPPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:15:10 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:49132 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262099AbVDRPPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:15:05 -0400
Subject: Re: [2.6 patch] remove cifs kcalloc
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org, samba-technical@lists.samba.org,
       davej@redhat.com, bunk@stusta.de
Content-Type: text/plain
Message-Id: <1113835532.5104.9.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 18 Apr 2005 09:45:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Apr 18, 2005 at 03:52:02AM +0200, Adrian Bunk wrote:
>> This patch removes cifs_kcalloc and replaces it with calls to
>> kcalloc(1, ...) .
>> 
>> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>As a followup patch you might want to check the return value
>of all those calls before blindly deferencing them.

I added checks for NULL return for kcalloc in the CIFS
development tree for the most important of the places 
(since the NTLMSSP and SPNEGO routines are going to 
need more changes anyway and are currently disabled
I did not add the NULL check to those three routines).

The patch can be seen at http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@4263c100xtDHBiI8HNqfzh05uw0jOA


