Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUCJOqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUCJOqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:46:38 -0500
Received: from apegate.roma1.infn.it ([141.108.7.31]:8071 "EHLO apona.ape")
	by vger.kernel.org with ESMTP id S262642AbUCJOph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:45:37 -0500
Message-ID: <404F2A0F.3010208@roma1.infn.it>
Date: Wed, 10 Mar 2004 15:45:35 +0100
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Janitor-like typo in expand_kiobuf
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

int expand_kiobuf(struct kiobuf *iobuf, int wanted)
{
    struct page ** maplist;
    
    if (iobuf->array_len >= wanted)
        return 0;
    
    maplist = kmalloc(wanted * sizeof(struct page **), GFP_KERNEL);
                                            ^^^^^^^^^^^^^^

I know that it is the same, but shouldn't it be 'sizeof(struct page *)' ??
regards
d.


