Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTAWFJf>; Thu, 23 Jan 2003 00:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTAWFJf>; Thu, 23 Jan 2003 00:09:35 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:54975 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264875AbTAWFJc> convert rfc822-to-8bit; Thu, 23 Jan 2003 00:09:32 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: [BENCHMARK] OSDB for 2.5.59, 2.4.18
Date: Thu, 23 Jan 2003 10:48:26 +0530
Message-ID: <94F20261551DC141B6B559DC491086720AEE09@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] OSDB for 2.5.59, 2.4.18
Thread-Index: AcLCnttCRr6z5jmgQ1uLk2TE6fGLfA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jan 2003 05:18:27.0457 (UTC) FILETIME=[DC304F10:01C2C29E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See below OSDB results for 5.59 and 4.18.

result for 2.5.52 and 2.4.19 posted by someone else (I guess Andrew or Paolo Ciarrocchi) 
http://groups.google.com/groups?q=osdb+group:linux.kernel&hl=en&lr=&ie=UTF-8&selm=20021222113754.15064.qmail%40linuxmail.org&rnum=1

Summary of his results:
2.4.19 "Single User Test"	806.78 seconds	(0:13:26.78)
2.5.52 "Single User Test"	3771.85 seconds	(1:02:51.85)

Summary of my results:
2.4.18 "Single User Test"	1599.88 seconds	(0:26:39.88)
2.5.59 "Single User Test"	1787.62 seconds	(0:29:47.62)

P III machine booted with mem=40M apm=off. DBMS - postgresql database - 40 MB
=============================================================================
2.5.59
=======
"osdb"
"Invoked: ./osdb-pg --nomulti"

                 create_tables()	0.08 seconds	return value = 0
                          load()	44.74 seconds	return value = 0
     create_idx_uniques_key_bt()	932.73 seconds	return value = 0
     create_idx_updates_key_bt()	967.18 seconds	return value = 0
     create_idx_hundred_key_bt()	771.71 seconds	return value = 0
      create_idx_tenpct_key_bt()	745.61 seconds	return value = 0
 create_idx_tenpct_key_code_bt()	3.29 seconds	return value = 0
        create_idx_tiny_key_bt()	0.27 seconds	return value = 0
      create_idx_tenpct_int_bt()	1.69 seconds	return value = 0
   create_idx_tenpct_signed_bt()	2.13 seconds	return value = 0
     create_idx_uniques_code_h()	20.91 seconds	return value = 0
   create_idx_tenpct_double_bt()	3.11 seconds	return value = 0
   create_idx_updates_decim_bt()	5.08 seconds	return value = 0
    create_idx_tenpct_float_bt()	2.43 seconds	return value = 0
     create_idx_updates_int_bt()	2.01 seconds	return value = 0
    create_idx_tenpct_decim_bt()	4.32 seconds	return value = 0
     create_idx_hundred_code_h()	5.53 seconds	return value = 0
      create_idx_tenpct_name_h()	151.39 seconds	return value = 0
     create_idx_updates_code_h()	19.44 seconds	return value = 0
      create_idx_tenpct_code_h()	16.01 seconds	return value = 0
  create_idx_updates_double_bt()	3.20 seconds	return value = 0
    create_idx_hundred_foreign()	13.38 seconds	return value = 0
              populateDataBase()	3671.42 seconds	return value = 0

"Logical database size 40.0000MB (38.1470MiB, 100000 tuples/relation)"

                      sel_1_cl()	0.31 seconds	return value = 1
                     join_3_cl()	0.17 seconds	return value = 0
                   sel_100_ncl()	0.80 seconds	return value = 100
                    table_scan()	0.82 seconds	return value = 0
                      agg_func()	13.59 seconds	return value = 100
                      agg_scal()	0.74 seconds	return value = 0
                    sel_100_cl()	0.83 seconds	return value = 100
                    join_3_ncl()	13.83 seconds	return value = 1
                 sel_10pct_ncl()	3.26 seconds	return value = 10000
             agg_simple_report()	83.91 seconds	return value = 990009900
            agg_info_retrieval()	3.15 seconds	return value = 0
               agg_create_view()	0.55 seconds	return value = 0
           agg_subtotal_report()	4.65 seconds	return value = 1000
              agg_total_report()	4.24 seconds	return value = 932849
                     join_2_cl()	0.13 seconds	return value = 0
                        join_2()	1.71 seconds	return value = 1000
       sel_variable_select_low()	0.78 seconds	return value = 0
      sel_variable_select_high()	3.89 seconds	return value = 25000
                     join_4_cl()	0.03 seconds	return value = 0
                      proj_100()	17.23 seconds	return value = 10000
                    join_4_ncl()	19.15 seconds	return value = 1
                    proj_10pct()	11.63 seconds	return value = 100000
                     sel_1_ncl()	0.16 seconds	return value = 1
                    join_2_ncl()	6.47 seconds	return value = 1
                integrity_test()	2.26 seconds	return value = 0
             drop_updates_keys()	0.50 seconds	return value = 0
                     bulk_save()	0.24 seconds	return value = 0
                   bulk_modify()	785.16 seconds	return value = 0
          upd_append_duplicate()	0.37 seconds	return value = 0
          upd_remove_duplicate()	0.08 seconds	return value = 0
                 upd_app_t_mid()	0.03 seconds	return value = 1
                 upd_mod_t_mid()	0.74 seconds	return value = 0
                 upd_del_t_mid()	0.83 seconds	return value = 0
                 upd_app_t_end()	0.08 seconds	return value = 1
                 upd_mod_t_end()	0.75 seconds	return value = 0
                 upd_del_t_end()	0.82 seconds	return value = 0
     create_idx_updates_code_h()	15.03 seconds	return value = 0
                 upd_app_t_mid()	0.33 seconds	return value = 1
                 upd_mod_t_cod()	0.05 seconds	return value = 0
                 upd_del_t_mid()	0.84 seconds	return value = 0
     create_idx_updates_int_bt()	2.52 seconds	return value = 0
                 upd_app_t_mid()	0.27 seconds	return value = 1
                 upd_mod_t_int()	0.01 seconds	return value = 0
                 upd_del_t_mid()	0.75 seconds	return value = 0
                   bulk_append()	4.73 seconds	return value = 0
                   bulk_delete()	778.61 seconds	return value = 0

"Single User Test"	1787.62 seconds	(0:29:47.62)
=======================================================================
2.4.18
=======
"osdb"
"Invoked: ./osdb-pg --nomulti"

                 create_tables()	0.13 seconds	return value = 0
                          load()	39.40 seconds	return value = 0
     create_idx_uniques_key_bt()	245.86 seconds	return value = 0
     create_idx_updates_key_bt()	110.40 seconds	return value = 0
     create_idx_hundred_key_bt()	133.14 seconds	return value = 0
      create_idx_tenpct_key_bt()	131.50 seconds	return value = 0
 create_idx_tenpct_key_code_bt()	3.44 seconds	return value = 0
        create_idx_tiny_key_bt()	0.17 seconds	return value = 0
      create_idx_tenpct_int_bt()	1.50 seconds	return value = 0
   create_idx_tenpct_signed_bt()	1.74 seconds	return value = 0
     create_idx_uniques_code_h()	22.20 seconds	return value = 0
   create_idx_tenpct_double_bt()	2.18 seconds	return value = 0
   create_idx_updates_decim_bt()	6.80 seconds	return value = 0
    create_idx_tenpct_float_bt()	2.20 seconds	return value = 0
     create_idx_updates_int_bt()	1.41 seconds	return value = 0
    create_idx_tenpct_decim_bt()	4.05 seconds	return value = 0
     create_idx_hundred_code_h()	5.39 seconds	return value = 0
      create_idx_tenpct_name_h()	169.98 seconds	return value = 0
     create_idx_updates_code_h()	14.99 seconds	return value = 0
      create_idx_tenpct_code_h()	15.53 seconds	return value = 0
  create_idx_updates_double_bt()	2.91 seconds	return value = 0
    create_idx_hundred_foreign()	13.28 seconds	return value = 0
              populateDataBase()	888.69 seconds	return value = 0

"Logical database size 40.0000MB (38.1470MiB, 100000 tuples/relation)"

                      sel_1_cl()	0.09 seconds	return value = 1
                     join_3_cl()	0.07 seconds	return value = 0
                   sel_100_ncl()	1.53 seconds	return value = 100
                    table_scan()	3.68 seconds	return value = 0
                      agg_func()	12.96 seconds	return value = 100
                      agg_scal()	3.79 seconds	return value = 0
                    sel_100_cl()	1.55 seconds	return value = 100
                    join_3_ncl()	12.09 seconds	return value = 1
                 sel_10pct_ncl()	3.25 seconds	return value = 10000
             agg_simple_report()	83.41 seconds	return value = 990009900
            agg_info_retrieval()	0.93 seconds	return value = 0
               agg_create_view()	0.23 seconds	return value = 0
           agg_subtotal_report()	4.61 seconds	return value = 1000
              agg_total_report()	4.36 seconds	return value = 932849
                     join_2_cl()	0.04 seconds	return value = 0
                        join_2()	4.74 seconds	return value = 1000
       sel_variable_select_low()	1.26 seconds	return value = 0
      sel_variable_select_high()	3.63 seconds	return value = 25000
                     join_4_cl()	0.02 seconds	return value = 0
                      proj_100()	16.66 seconds	return value = 10000
                    join_4_ncl()	17.82 seconds	return value = 1
                    proj_10pct()	10.32 seconds	return value = 100000
                     sel_1_ncl()	0.06 seconds	return value = 1
                    join_2_ncl()	5.91 seconds	return value = 1
                integrity_test()	2.18 seconds	return value = 0
             drop_updates_keys()	0.16 seconds	return value = 0
                     bulk_save()	0.18 seconds	return value = 0
                   bulk_modify()	732.35 seconds	return value = 0
          upd_append_duplicate()	0.14 seconds	return value = 0
          upd_remove_duplicate()	0.02 seconds	return value = 0
                 upd_app_t_mid()	0.00 seconds	return value = 1
                 upd_mod_t_mid()	0.82 seconds	return value = 0
                 upd_del_t_mid()	0.83 seconds	return value = 0
                 upd_app_t_end()	0.06 seconds	return value = 1
                 upd_mod_t_end()	0.81 seconds	return value = 0
                 upd_del_t_end()	0.81 seconds	return value = 0
     create_idx_updates_code_h()	15.07 seconds	return value = 0
                 upd_app_t_mid()	0.01 seconds	return value = 1
                 upd_mod_t_cod()	0.01 seconds	return value = 0
                 upd_del_t_mid()	1.04 seconds	return value = 0
     create_idx_updates_int_bt()	2.37 seconds	return value = 0
                 upd_app_t_mid()	0.01 seconds	return value = 1
                 upd_mod_t_int()	0.01 seconds	return value = 0
                 upd_del_t_mid()	0.79 seconds	return value = 0
                   bulk_append()	2.57 seconds	return value = 0
                   bulk_delete()	646.38 seconds	return value = 0

"Single User Test"	1599.88 seconds	(0:26:39.88)
========================================================================

Aniruddha Marathe
WIPRO TECHNOLOGIES, INDIA
